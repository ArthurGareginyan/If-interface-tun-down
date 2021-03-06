# Поднятие сетевого интерфейса при падении

Для получения адреса IPv6 на одном из серверов я пользуюсь услугами тунельного брокера gogo6.com. Для подключения к брокеру используется программа “gogoc” (gogo client), которая поднимает виртуальный интерфейс “tun” для создания тунеля. Но, время от времени, этот интерфейс падает, что делает сервер более не доступным по IPv6 адресу.
Причину падения интерфейса я определил но решил ,что оптимальным решением будет перезапускать интерфейс в случае падения. Для этого я написал сценарий на “Shell” проверяющий нужный интерфейс на существование, а в случае отсутствия перезапускающий программу “gogoc”. И ещё неообходима запись в “cron” для запуска этого сценария по расписанию.

Код написан под перезапуск gogoc но может быть легко переделан под другие нужды.

Необходимо файлу дать права на исполнение:
```
chmod +x IfDownTun.sh
```

И сделать запись в “cron” для автоматического запуска скрипта по расписанию:
```
sudo nano /etc/crontab
```

```
# Test if iface tun is down
*/3 *   * * *   root    /home/IfDownTun.sh
```

Сценарий также пишет логи в /var/log/iface_tun.log

В таком формате:
```
2014-03-18(02:51) iface tun DOWN
2014-03-19(16:45) iface tun UP
2014-03-19(16:48) iface tun DOWN
2014-03-20(16:21) iface tun UP
2014-03-20(22:57) iface tun DOWN
2014-03-20(22:57) iface tun UP
2014-03-21(14:51) iface tun DOWN
2014-03-21(14:51) iface tun UP
```

## License

This script is licensed under the [GNU General Public License, version 3 (GPLv3)](http://www.gnu.org/licenses/gpl-3.0.html) and is distributed free of charge.

Commercial licensing (e.g. for projects that can’t use an open-source license) is available upon request.


## Author

Arthur Garegnyan

* Email: arthurgareginyan@gmail.com

* GitHub: [https://github.com/ArthurGareginyan/](https://github.com/ArthurGareginyan/)

* Website: [http://www.arthurgareginyan.com](http://www.arthurgareginyan.com)

* Donation: [http://www.arthurgareginyan.com/donate.html](http://www.arthurgareginyan.com/donate.html)
