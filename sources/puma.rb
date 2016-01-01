environment 'production'

pidfile 'puma.pid'

threads 0,1
workers 1

#daemonize true

bind 'tcp://127.0.0.1:4567'
