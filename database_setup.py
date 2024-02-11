import mysql.connector

cnx = mysql.connector.connect(
    user="root", password="edison9138", host="127.0.0.1", database="Vosik"
)

cursor = cnx.cursor()

query = "INSERT INTO songs (id, song_name, intensity, duration_ms, track_href, album_image) VALUES (%s, %s, %s, %s, %s, %s);"

data = open("track_data.tsv", "r", encoding="utf-8")

lines = data.readlines()

# i for skipping the attribute row
i = 0
for line in lines:
    if i == 0:
        i += 1
        continue
    parts = line.split("\t")
    print(parts[0])
    id = parts[1]
    name = parts[2]
    intensity = float(parts[3])
    cursor.execute(query, (id, name, intensity, float(parts[4]), parts[5], parts[6]))

cnx.commit()

cnx.close()
