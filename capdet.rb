require 'open-uri'
require 'json'

content = open('http://localhost:9292/api/v1/cadet/soumya.ray.json').read
content
js = JSON.parse(content)
js
js["id"]
js["badges"]
js["badges"][2]
js["badges"].select {|badge| badge["id"] == "10 Exercises" }
