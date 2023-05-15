const express = require("express");
const puppeteer = require("puppeteer");
const fetch = require("node-fetch");
const cors = require("cors");

const app = express();
app.use(cors());

const PORT = 5000;

app.get("/", async (req, res) => {
  try {
    let url = req?.query?.url || req?.query?.json;
    if (req?.query?.url) {
      const browser = await puppeteer.launch({
        headless: true,
        args: ["--no-sandbox", "--disable-setuid-sandbox"],
      });
      const page = await browser.newPage();
      await page.setUserAgent(
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36"
      );

      let status = true;
      page.on("console", (msg) => {
        if (msg.text().includes("404")) {
          status = false;
        }
      });

      await page.goto(req.query.url);
      res.json({ status });
      await browser.close();
    } else if (req?.query?.web) {
      const response = await fetch(req?.query?.web);
      const text = await response.text();
      res.send(text);
    }
  } catch (error) {
    console.log("server crashed", error);
    res.status(500).send(error);
  }
});

app.listen(PORT, () => {
  console.log(`Listening on port ${PORT}`);
});
