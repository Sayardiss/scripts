for year in {1990..2017}
do
  for edition in `seq -w 1 12`
  do
    echo "$year""$edition"
    #curl 'https://www.elektormagazine.fr/magazine/elektor-'"$year$edition"
    URL='https://www.elektormagazine.fr/files/magazine/'"$year"'/magazine/FR'"$year$edition"'.pdf'
    echo "$URL"

    AMZN=$( curl "$URL" -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: fr-FR,en-US;q=0.8,fr;q=0.6,en;q=0.4' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/61.0.3163.79 Chrome/61.0.3163.79 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: https://www.elektormagazine.fr/magazine/elektor-201103' -H 'Cookie: style=eyJpdiI6Ik5kZm9CQUFkOTI2SlwvTk1pWjI2WVRRPT0iLCJ2YWx1ZSI6IkM2SVBMdHFRMEJrUXEydVEwcXU2Z2xzYWtiVklcL2tJZ0FRWTZESFpDUVI0OUlqK1JWdXJya05zN29oZ1RrcFFqIiwibWFjIjoiNjAyZDQ0ZDMxNThlZjhhMTI2NjYxYTU0YmMwYTcxZjNmOTY2NzBiMzZlM2EzYzU1NTdmNTEwY2JkOWU2N2VjMiJ9; remember_front_59ba36addc2b2f9401580f014c7f58ea4e30989d=eyJpdiI6Ilwvb0thNEY0TWRFazdkUElpYmc4WmhRPT0iLCJ2YWx1ZSI6IjE0VDhxOW8zTm1FZVppRmFlcUFqM3Q3WGhcL0hSVTJcLzF0bDN3ampFVXd5THltMWJPMlFDYjRFUno1MmZBemtFZkM0dVdyN1RZS0VjSHlSRHZjcEorSnlKa0k0TmZ3MldLU3ZTc25heFdLZ2ZGSGFUc2hMYW9CRStkcHU4RTZMWHMiLCJtYWMiOiIyOGRmN2RiYWE1Mjg1MTU3ZThhNzE0NGU0NWVlZjY2MzE2MGYyODk4YmRmYzRmODMyZDkxNWFlMzM5OTk5NDBlIn0%3D; u=eyJpdiI6IlZjbllBK2RcL1pGTmlkdm9kdTM4SEJBPT0iLCJ2YWx1ZSI6IkNNblJjTzF3XC92VXpUV0FlSG5NZVZRPT0iLCJtYWMiOiI4ZmFmYjI4YjUyYjc2NzM4YzgyOThhMjVjNmJlNzM4NmJlOWY4MDhhODkzNzIwYWNiZDMzNTE1ODFjM2Y1YzY3In0%3D; XSRF-TOKEN=eyJpdiI6IlBxTnhzMzJTR2FsUkE4QmUwc3NSMUE9PSIsInZhbHVlIjoiWk55bk5sWjBhVDRCZktBT0hLMlNab2tpWnE1VGZoK1dVRmlvSm8yN2wrelkxTkxFQjU3SVRaUlVIMENBZUJxMTIwak5HYnlTc2dkRld5QThuSnU3dHc9PSIsIm1hYyI6ImM4OTRjNDc2MTczZTA2NWIwNDA0ZmM3OWI3NmMzOWFhMTFkMjlmNDE1YWExNjNiYWJkZTlhMDkyMTEwMjU3NTMifQ%3D%3D; elektor_session=eyJpdiI6Inp6cUVpQk02QUlRVEFvTjdTS1U3N2c9PSIsInZhbHVlIjoienJ0MWoyc01DSXhwc0UyN1FPQ05YMjlcLzAzTjNOU1Z5K2NXRWJEc1wvRzRFQnJNM1JDYlRaMm5BUlJyYk52ZklPK1dCb2VyMWRrc1ZpZTB4TnlmNHVqdz09IiwibWFjIjoiMWIzZjc2MTk0MDZhODNiMWYyM2UzNWM3ODM1MGY0NTg4YzcyZGFjZjc0NGFkZGQ2M2I0ZjJjYzU4YmE3YzNiYSJ9' -v 2>&1 | egrep -o "Location.*$" | cut -d" " -f2 )

    AMZN=${AMZN%$'\r'}
    echo "$AMZN"

    # Retirer \r
    wget "$AMZN" -O "Elektor-$year-$edition.pdf"
  done
done
