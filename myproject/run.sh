#deploy django application

#activate virtual environment
source /home/ubuntu/myprojectenv/bin/activate

#install required packages
pip install -r /home/ubuntu/myproject/requirements.txt

#run django migrations
python /home/ubuntu/myproject/manage.py migrate

#run django server
python /home/ubuntu/myproject/manage.py runserver
```

### 4. Create a systemd service file

```bash
sudo nano /etc/systemd/system/myproject.service
```

```bash
# /etc/systemd/system/myproject.service
[Unit]
Description=Gunicorn instance to serve myproject
After=network.target