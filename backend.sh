dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y

cp backend.service /etc/systemd/system/backend.service
useradd expense
rm -rf /app
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip
npm install


systemctl daemon-reload
systemctl enable backend
systemctl restart backend

dnf install mysql -y
mysql -h 172.31.42.61 -uroot -pExpenseApp@1 < /app/schema/backend.sql