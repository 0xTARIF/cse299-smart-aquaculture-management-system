import smtplib
from email.mime.text import MIMEText

EMAIL = "phonekyc1@gmail.com"
PASSWORD = "jobyjcfevrmdrmao"

def send_email(to_email, otp):
    subject = "Your OTP Code"
    body = f"Your OTP is: {otp}"

    msg = MIMEText(body)
    msg['Subject'] = subject
    msg['From'] = EMAIL
    msg['To'] = to_email

    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
        server.login(EMAIL, PASSWORD)
        server.sendmail(EMAIL, to_email, msg.as_string())


#send_email("tarifbinmehedicrp@gmail.com", "343231")