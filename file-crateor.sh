current_dir=$(pwd)

# Get script name
script_name=$(basename "$0")

# Join current directory with script name
full_path="${current_dir}/${script_name}"
chmod +x $full_path
mkdir -p app/{constant,middleware,modules/{post,user},routers,utils,validator} public src
touch app/server.js app/utils/{mongoose-connection.js,error-handler.js} public/{favicon.ico,index.html,robots.txt} src/{index.css,index.js} app/routers/routes.js .env .gitignore README.md index.js


