import requests
import xml.etree.ElementTree as ET
import json


BASE_URL = "http://export.arxiv.org/api/query"
SEARCH_QUERY = "all:machine learning"
MAX_RESULTS = 250

params = {
    "search_query": SEARCH_QUERY,
    "start": 0,
    "max_results": MAX_RESULTS
}

print("Fetching data from arXiv API...")

response = requests.get(BASE_URL, params=params)

if response.status_code != 200:
    raise Exception(f"API request failed with status {response.status_code}")

xml_data = response.text

# Save raw XML (optional but useful)
with open("raw_data.xml", "w", encoding="utf-8") as f:
    f.write(xml_data)

print("✅ Raw XML saved")

ns = {"atom": "http://www.w3.org/2005/Atom"}
root = ET.fromstring(xml_data)

data = []

for entry in root.findall("atom:entry", ns):

    title = entry.find("atom:title", ns)
    summary = entry.find("atom:summary", ns)
    published = entry.find("atom:published", ns)

    title = title.text.strip() if title is not None else ""
    summary = summary.text.strip() if summary is not None else ""
    published = published.text if published is not None else ""

    authors = []
    for author in entry.findall("atom:author", ns):
        name = author.find("atom:name", ns)
        if name is not None:
            authors.append(name.text.strip())

    record = {
        "title": title,
        "summary": summary,
        "published": published,
        "authors": authors
    }

    data.append(record)

print(f"Parsed {len(data)} records")


with open("clean_data.json", "w", encoding="utf-8") as f:
    for record in data:
        f.write(json.dumps(record) + "\n")

print("clean_data.json created (Spark-ready)")

print("Data ingestion completed successfully!")