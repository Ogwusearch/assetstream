import express from "express";
import cors from "cors";

const app = express();
app.use(cors());

app.get("/", (req, res) => {
  res.json({ status: "AssetStream Backend Running" });
});

app.get("/health", (req, res) => {
  res.json({ ok: true });
});

app.listen(4000, () => {
  console.log("AssetStream Backend running on port 4000");
});
