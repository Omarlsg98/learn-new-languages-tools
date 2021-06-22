from google.cloud import bigquery
# https://cloud.google.com/bigquery/docs/reference/libraries#client-libraries-install-python
# Construct a BigQuery client object.
# TODO: separete this in a singleton
client = bigquery.Client()


def create_query(cur_query):
    query_job = client.query(cur_query)
    return query_job
    # print("The query data:")
    # for row in query_job:
    #     # Row values can be accessed by field name or index.
    #     print("name={}, count={}".format(row[0], row["total_people"]))


if __name__ == "__main__":
    query = """
        SELECT name, SUM(number) as total_people
        FROM `bigquery-public-data.usa_names.usa_1910_2013`
        WHERE state = 'TX'
        GROUP BY name, state
        ORDER BY total_people DESC
        LIMIT 20
    """
