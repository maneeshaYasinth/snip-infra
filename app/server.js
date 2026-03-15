const express = require("express");
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const {
  DynamoDBDocumentClient,
  PutCommand,
  GetCommand,
  ScanCommand,
} = require("@aws-sdk/lib-dynamodb");
const { nanoid } = require("nanoid");
const path = require("path");

const app = express();
app.use(express.json());
app.use(express.static(path.join(__dirname, "public")));

// ── DynamoDB client ──────────────────────────────────────────────────────────
const client = new DynamoDBClient({
  region: process.env.AWS_REGION || "us-east-1",
});
const db = DynamoDBDocumentClient.from(client);

const TABLE_NAME = process.env.DYNAMODB_TABLE || "url-shortener";
const BASE_URL = process.env.BASE_URL || `http://localhost:${process.env.PORT || 3000}`;

// ── POST /shorten ────────────────────────────────────────────────────────────
app.post("/shorten", async (req, res) => {
  const { longUrl } = req.body;

  if (!longUrl) {
    return res.status(400).json({ error: "longUrl is required" });
  }

  // Basic URL validation
  try {
    new URL(longUrl);
  } catch {
    return res.status(400).json({ error: "Invalid URL format" });
  }

  const shortCode = nanoid(7);
  const createdAt = new Date().toISOString();

  try {
    await db.send(
      new PutCommand({
        TableName: TABLE_NAME,
        Item: {
          shortCode,
          longUrl,
          createdAt,
          clicks: 0,
        },
      })
    );

    return res.status(201).json({
      shortUrl: `${BASE_URL}/${shortCode}`,
      shortCode,
      longUrl,
      createdAt,
    });
  } catch (err) {
    console.error("DynamoDB PutCommand error:", err);
    return res.status(500).json({ error: "Failed to save URL" });
  }
});

// ── GET /urls (admin list) ───────────────────────────────────────────────────
app.get("/urls", async (req, res) => {
  try {
    const result = await db.send(new ScanCommand({ TableName: TABLE_NAME }));
    const items = (result.Items || []).sort(
      (a, b) => new Date(b.createdAt) - new Date(a.createdAt)
    );
    return res.json(items);
  } catch (err) {
    console.error("DynamoDB ScanCommand error:", err);
    return res.status(500).json({ error: "Failed to fetch URLs" });
  }
});

// ── GET /:code (redirect) ────────────────────────────────────────────────────
app.get("/:code", async (req, res) => {
  const { code } = req.params;

  // Skip favicon and other static requests
  if (code === "favicon.ico") return res.status(404).end();

  try {
    const result = await db.send(
      new GetCommand({
        TableName: TABLE_NAME,
        Key: { shortCode: code },
      })
    );

    if (!result.Item) {
      return res.status(404).sendFile(path.join(__dirname, "public", "404.html"));
    }

    // Fire-and-forget click increment
    db.send(
      new PutCommand({
        TableName: TABLE_NAME,
        Item: {
          ...result.Item,
          clicks: (result.Item.clicks || 0) + 1,
        },
      })
    ).catch(console.error);

    return res.redirect(301, result.Item.longUrl);
  } catch (err) {
    console.error("DynamoDB GetCommand error:", err);
    return res.status(500).json({ error: "Internal server error" });
  }
});

// ── Health check (for ALB) ───────────────────────────────────────────────────
app.get("/health", (req, res) => res.json({ status: "ok" }));

// ── Start ────────────────────────────────────────────────────────────────────
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`URL shortener running on port ${PORT}`);
  console.log(`DynamoDB table: ${TABLE_NAME}`);
  console.log(`Base URL: ${BASE_URL}`);
});