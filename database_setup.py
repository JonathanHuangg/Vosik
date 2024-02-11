import mysql.connector

cnx = mysql.connector.connect(user='hacklytics', 
    password='mobilize privacy swooned gap blip', host='127.0.0.1', database='music')

cursor = cnx.cursor()

query = "INSERT INTO songs (id, song_name, intensity) VALUES (%s, %s, %s);"

data = open("energy.tsv", "r", encoding="utf-8")

lines = data.readlines()

for line in lines:
    parts = line.split("\t")
    id = parts[1]
    name = parts[2]
    intensity = float(parts[3])
    cursor.execute(query, (id, name, intensity))

cnx.commit()

cnx.close()
