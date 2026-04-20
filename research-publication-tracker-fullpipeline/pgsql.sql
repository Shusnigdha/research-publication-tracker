CREATE TABLE papers (
    title TEXT,
    summary TEXT,
    published TIMESTAMP,
    paper_id INT PRIMARY KEY
);

CREATE TABLE authors (
    author TEXT,
    author_id INT PRIMARY KEY
);

CREATE TABLE paper_author (
    paper_id INT,
    author_id INT,
    PRIMARY KEY (paper_id, author_id),
    FOREIGN KEY (paper_id) REFERENCES papers(paper_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

SELECT * FROM papers;

SELECT * FROM authors;

SELECT * FROM paper_author;

-- adding index
CREATE INDEX idx_paper_id ON papers(paper_id);
CREATE INDEX idx_author_id ON authors(author_id);
CREATE INDEX idx_pa_paper ON paper_author(paper_id);
CREATE INDEX idx_pa_author ON paper_author(author_id);

--OLAP table
CREATE TABLE paper_summary AS
SELECT 
    p.paper_id,
    p.title,
    COUNT(pa.author_id) AS author_count,
    p.published
FROM paper_author pa
JOIN papers p ON pa.paper_id = p.paper_id
GROUP BY p.paper_id, p.title, p.published;

SELECT * FROM paper_summary LIMIT 10;

-- DATA QUALITY CHECKS

-- duplicate itles
SELECT title, COUNT(*)
FROM papers
GROUP BY title
HAVING COUNT(*) > 1;

-- missing values
SELECT *
FROM papers
WHERE title IS NULL OR published IS NULL;

-- monthly publication trend
CREATE VIEW publication_trend AS
SELECT 
    DATE_TRUNC('month', published) AS month_date,
    TO_CHAR(DATE_TRUNC('month', published), 'YYYY-MM') AS month,
    COUNT(*) AS total_papers
FROM papers
GROUP BY month_date, month
ORDER BY month_date;

SELECT * FROM publication_trend;

-- top authors
CREATE OR REPLACE VIEW top_authors AS
SELECT 
    a.author,
    COUNT(*) AS paper_count
FROM paper_author pa
JOIN authors a ON pa.author_id = a.author_id
GROUP BY a.author
ORDER BY paper_count DESC;

SELECT * from top_authors;

-- yearly growth
CREATE OR REPLACE VIEW yearly_growth AS
SELECT 
    year,
    total_papers,
    total_papers - LAG(total_papers) OVER (ORDER BY year) AS growth
FROM (
    SELECT 
        DATE_PART('year', published) AS year,
        COUNT(*) AS total_papers
    FROM papers
    GROUP BY year
) sub;

SELECT * FROM yearly_growth;

-- distribution of authors per paper
SELECT 
    author_count,
    COUNT(*) AS num_papers
FROM paper_summary
GROUP BY author_count
ORDER BY author_count;

-- collaborators per author
SELECT 
    a.author,
    COUNT(DISTINCT pa2.author_id) AS collaborators
FROM paper_author pa1
JOIN paper_author pa2 
    ON pa1.paper_id = pa2.paper_id 
    AND pa1.author_id != pa2.author_id
JOIN authors a ON pa1.author_id = a.author_id
GROUP BY a.author
ORDER BY collaborators DESC;

-- author ranking
SELECT 
    a.author,
    COUNT(*) AS paper_count,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
FROM paper_author pa
JOIN authors a ON pa.author_id = a.author_id
GROUP BY a.author;

-- kpi summary
SELECT
    (SELECT COUNT(*) FROM papers) AS total_papers,
    (SELECT COUNT(*) FROM authors) AS total_authors,
    (SELECT AVG(author_count) FROM paper_summary) AS avg_authors_per_paper;

-- avg authors per year
SELECT 
    DATE_PART('year', p.published) AS year,
    AVG(ps.author_count) AS avg_authors
FROM paper_summary ps
JOIN papers p ON ps.paper_id = p.paper_id
GROUP BY year
ORDER BY year;

-- top collaborators
SELECT 
    a1.author AS author1,
    a2.author AS author2,
    COUNT(*) AS collaborations
FROM paper_author pa1
JOIN paper_author pa2 
    ON pa1.paper_id = pa2.paper_id 
    AND pa1.author_id < pa2.author_id
JOIN authors a1 ON pa1.author_id = a1.author_id
JOIN authors a2 ON pa2.author_id = a2.author_id
GROUP BY author1, author2
ORDER BY collaborations DESC
LIMIT 10;

-- top active years
SELECT 
    DATE_PART('year', published) AS year,
    COUNT(*) AS total_papers
FROM papers
GROUP BY year
ORDER BY total_papers DESC
LIMIT 5;