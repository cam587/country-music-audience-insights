DROP TABLE IF EXISTS statedemo;
CREATE TABLE statedemo (
    "County" TEXT,
    "State" TEXT,
    "Age.Percent 65 and Older" NUMERIC,
    "Age.Percent Under 18 Years" NUMERIC,
    "Age.Percent Under 5 Years" NUMERIC,
    "Education.Bachelor's Degree or Higher" NUMERIC,
    "Education.High School or Higher" NUMERIC,
    "Employment.Nonemployer Establishments" INTEGER,
    "Ethnicities.American Indian and Alaska Native Alone" NUMERIC,
    "Ethnicities.Asian Alone" NUMERIC,
    "Ethnicities.Black Alone" NUMERIC,
    "Ethnicities.Hispanic or Latino" NUMERIC,
    "Ethnicities.Native Hawaiian and Other Pacific Islander Alone" NUMERIC,
    "Ethnicities.Two or More Races" NUMERIC,
    "Ethnicities.White Alone" NUMERIC,
    "Ethnicities.White Alone	 not Hispanic or Latino" NUMERIC,
    "Housing.Homeownership Rate" NUMERIC,
    "Housing.Households" INTEGER,
    "Housing.Housing Units" INTEGER,
    "Housing.Median Value of Owner-Occupied Units" INTEGER,
    "Housing.Persons per Household" NUMERIC,
    "Income.Median Houseold Income" INTEGER,
    "Income.Per Capita Income" INTEGER,
    "Miscellaneous.Foreign Born" NUMERIC,
    "Miscellaneous.Land Area" NUMERIC,
    "Miscellaneous.Language Other than English at Home" NUMERIC,
    "Miscellaneous.Living in Same House +1 Years" NUMERIC,
    "Miscellaneous.Manufacturers Shipments" BIGINT,
    "Miscellaneous.Mean Travel Time to Work" NUMERIC,
    "Miscellaneous.Percent Female" NUMERIC,
    "Miscellaneous.Veterans" INTEGER,
    "Population.2020 Population" INTEGER,
    "Population.2010 Population" INTEGER,
    "Population.Population per Square Mile" NUMERIC,
    "Sales.Accommodation and Food Services Sales" BIGINT,
    "Sales.Retail Sales" BIGINT,
    "Employment.Firms.Total" INTEGER,
    "Employment.Firms.Women-Owned" INTEGER,
    "Employment.Firms.Men-Owned" INTEGER,
    "Employment.Firms.Minority-Owned" INTEGER,
    "Employment.Firms.Nonminority-Owned" INTEGER,
    "Employment.Firms.Veteran-Owned" INTEGER,
    "Employment.Firms.Nonveteran-Owned" INTEGER
);
ALTER TABLE statedemo
ADD COLUMN region TEXT;
UPDATE statedemo
SET region = CASE "State"
    WHEN 'AL' THEN 'South'
    WHEN 'AK' THEN 'West'
    WHEN 'AZ' THEN 'West'
    WHEN 'AR' THEN 'South'
    WHEN 'CA' THEN 'West'
    WHEN 'CO' THEN 'West'
    WHEN 'CT' THEN 'North'
    WHEN 'DE' THEN 'South'
    WHEN 'DC' THEN 'North'
    WHEN 'FL' THEN 'South'
    WHEN 'GA' THEN 'South'
    WHEN 'HI' THEN 'West'
    WHEN 'ID' THEN 'West'
    WHEN 'IL' THEN 'Midwest'
    WHEN 'IN' THEN 'Midwest'
    WHEN 'IA' THEN 'Midwest'
    WHEN 'KS' THEN 'Midwest'
    WHEN 'KY' THEN 'South'
    WHEN 'LA' THEN 'South'
    WHEN 'ME' THEN 'North'
    WHEN 'MD' THEN 'North'
    WHEN 'MA' THEN 'North'
    WHEN 'MI' THEN 'Midwest'
    WHEN 'MN' THEN 'Midwest'
    WHEN 'MS' THEN 'South'
    WHEN 'MO' THEN 'Midwest'
    WHEN 'MT' THEN 'West'
    WHEN 'NE' THEN 'Midwest'
    WHEN 'NV' THEN 'West'
    WHEN 'NH' THEN 'North'
    WHEN 'NJ' THEN 'North'
    WHEN 'NM' THEN 'West'
    WHEN 'NY' THEN 'North'
    WHEN 'NC' THEN 'South'
    WHEN 'ND' THEN 'Midwest'
    WHEN 'OH' THEN 'Midwest'
    WHEN 'OK' THEN 'South'
    WHEN 'OR' THEN 'West'
    WHEN 'PA' THEN 'North'
    WHEN 'RI' THEN 'North'
    WHEN 'SC' THEN 'South'
    WHEN 'SD' THEN 'Midwest'
    WHEN 'TN' THEN 'South'
    WHEN 'TX' THEN 'South'
    WHEN 'UT' THEN 'West'
    WHEN 'VT' THEN 'North'
    WHEN 'VA' THEN 'South'
    WHEN 'WA' THEN 'West'
    WHEN 'WV' THEN 'South'
    WHEN 'WI' THEN 'Midwest'
    WHEN 'WY' THEN 'West'
    ELSE NULL
END;


SELECT 
    "State",
    AVG("Education.Bachelor's Degree or Higher") AS avg_bachelors_degree_or_higher_p,
    AVG("Ethnicities.Asian Alone") AS avg_asian_p,
    AVG("Ethnicities.Black Alone") AS avg_black_p,
    AVG("Ethnicities.White Alone") AS avg_white_p,
    AVG("Ethnicities.Hispanic or Latino") AS avg_hispanic_or_latino_p,
    AVG("Income.Median Houseold Income") AS avg_median_household_income,
	region
FROM statedemo
GROUP BY "State", region
ORDER BY "State";




SELECT *
FROM cmst
ORDER BY country_music_interest
LIMIT 10;

-- state & interest group
SELECT
	state,
	c.country_music_interest,
    CASE
        WHEN c.country_music_interest >= 47 THEN 'High Interest'
        WHEN c.country_music_interest >= 29 AND c.country_music_interest < 55 THEN 'Medium Interest'
        ELSE 'Low Interest'
    END AS interest_group,
	region
FROM cmst c
JOIN statedemo d
    ON c.state = d."State"
GROUP BY state, c.country_music_interest, region
ORDER BY c.country_music_interest DESC
;

-- median income vs interest level
SELECT
	state,
	AVG("Income.Median Houseold Income") AS avg_median_household_income,
    CASE
        WHEN c.country_music_interest >= 50 THEN 'High Interest'
        WHEN c.country_music_interest >= 29 AND c.country_music_interest < 55 THEN 'Medium Interest'
        ELSE 'Low Interest'
    END AS interest_group,
	c.country_music_interest
FROM cmst c
JOIN statedemo d
    ON c.state = d."State"
GROUP BY state, c.country_music_interest
ORDER BY avg_median_household_income
;

-- education level vs interest level
SELECT
	state,
	AVG("Education.Bachelor's Degree or Higher") AS avg_bachelors_degree_or_higher_p,
    CASE
        WHEN c.country_music_interest >= 50 THEN 'High Interest'
        WHEN c.country_music_interest >= 29 AND c.country_music_interest < 55 THEN 'Medium Interest'
        ELSE 'Low Interest'
    END AS interest_group,
	c.country_music_interest
FROM cmst c
JOIN statedemo d
    ON c.state = d."State"
GROUP BY state, c.country_music_interest
ORDER BY avg_bachelors_degree_or_higher_p
;

-- Ethnicities by interest group
SELECT
	state,
	AVG("Ethnicities.Asian Alone") AS avg_asian_p,
    AVG("Ethnicities.Black Alone") AS avg_black_p,
    AVG("Ethnicities.White Alone") AS avg_white_p,
    AVG("Ethnicities.Hispanic or Latino") AS avg_hispanic_or_latino_p,
    CASE
        WHEN c.country_music_interest >= 50 THEN 'High Interest'
        WHEN c.country_music_interest >= 29 AND c.country_music_interest < 55 THEN 'Medium Interest'
        ELSE 'Low Interest'
    END AS interest_group,
	c.country_music_interest
FROM cmst c
JOIN statedemo d
    ON c.state = d."State"
GROUP BY state, c.country_music_interest
ORDER BY avg_white_p DESC
;

SELECT *
FROM cmst;



-- Demographics by interest group
WITH joined_data AS (
    SELECT
        s."State",
        c.country_music_interest,
        CASE
            WHEN c.country_music_interest >= 50 THEN 'High Interest'
            WHEN c.country_music_interest >= 29 THEN 'Medium Interest'
            ELSE 'Low Interest'
        END AS interest_group,
        "Ethnicities.Asian Alone" AS asian_p,
        "Ethnicities.Black Alone" AS black_p,
        "Ethnicities.White Alone" AS white_p,
        "Ethnicities.Hispanic or Latino" AS hispanic_or_latino_p
    FROM statedemo s
    INNER JOIN cmst c
        ON s."State" = c.state
)
SELECT
    interest_group,
    AVG(country_music_interest) AS avg_country_music_interest,
    AVG(asian_p) AS avg_asian_p,
    AVG(black_p) AS avg_black_p,
    AVG(white_p) AS avg_white_p,
    AVG(hispanic_or_latino_p) AS avg_hispanic_or_latino_p
FROM joined_data
GROUP BY interest_group
ORDER BY avg_country_music_interest DESC;

-- Demographics by region and avg interest ratings -- BEST SUMMARY FOR EVERYTHING
SELECT
    d.region,
    ROUND(AVG(c.country_music_interest), 1) AS avg_country_music_interest,
    ROUND(AVG(d."Education.Bachelor's Degree or Higher"), 2) AS avg_bachelors_degree_or_higher_p,
    ROUND(AVG(d."Ethnicities.Asian Alone"), 2) AS avg_asian_p,
    ROUND(AVG(d."Ethnicities.Black Alone"), 2) AS avg_black_p,
    ROUND(AVG(d."Ethnicities.White Alone"), 2) AS avg_white_p,
    ROUND(AVG(d."Ethnicities.Hispanic or Latino"), 2) AS avg_hispanic_or_latino_p,
    ROUND(AVG(d."Income.Median Houseold Income"), 0) AS avg_median_household_income
FROM cmst c
JOIN statedemo d
    ON c.state = d."State"
GROUP BY d.region
ORDER BY avg_country_music_interest DESC;

-- Northern States focus
SELECT
    c.state,
    d.region,
    c.country_music_interest,
    AVG(d."Education.Bachelor's Degree or Higher") AS avg_bachelors_degree_or_higher_p,
    AVG(d."Ethnicities.Asian Alone") AS avg_asian_p,
    AVG(d."Ethnicities.Black Alone") AS avg_black_p,
    AVG(d."Ethnicities.White Alone") AS avg_white_p,
    AVG(d."Ethnicities.Hispanic or Latino") AS avg_hispanic_or_latino_p,
    AVG(d."Income.Median Houseold Income") AS avg_median_household_income
FROM cmst c
JOIN statedemo d
    ON c.state = d."State"
WHERE d.region = 'North'
GROUP BY 
    c.state,
    d.region,
    c.country_music_interest
ORDER BY c.country_music_interest DESC;

-- For interst level vs state:
CREATE VIEW clean_state_interest AS 
SELECT
	state,
	c.country_music_interest,
    CASE
        WHEN c.country_music_interest >= 47 THEN 'High Interest'
        WHEN c.country_music_interest >= 29 AND c.country_music_interest < 55 THEN 'Medium Interest'
        ELSE 'Low Interest'
    END AS interest_group,
	region
FROM cmst c
JOIN statedemo d
    ON c.state = d."State"
GROUP BY state, c.country_music_interest, region
ORDER BY c.country_music_interest DESC
;

-- For median income vs interest level:
CREATE VIEW clean_income_interest AS 
SELECT
	state,
	AVG("Income.Median Houseold Income") AS avg_median_household_income,
    CASE
        WHEN c.country_music_interest >= 50 THEN 'High Interest'
        WHEN c.country_music_interest >= 29 AND c.country_music_interest < 55 THEN 'Medium Interest'
        ELSE 'Low Interest'
    END AS interest_group,
	c.country_music_interest
FROM cmst c
JOIN statedemo d
    ON c.state = d."State"
GROUP BY state, c.country_music_interest
ORDER BY avg_median_household_income
;
