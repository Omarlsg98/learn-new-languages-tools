SELECT
    word,
    (
        SELECT
            ARRAY_AGG(
                title
                )
        FROM
            UNNEST(usages) usage WITH OFFSET index
        WHERE index BETWEEN 1 AND 3
    ) AS main_titles
FROM `datatonbc-heimdall.learn_languages.wiki_title_word_count`
LIMIT 1000