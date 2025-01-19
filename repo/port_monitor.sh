#!/bin/bash

LOG="/var/log/port_monitor.log"
PERIOD="60"
echo="Spinning up monitor" >> $LOG
while true; do
  echo "----------" >> $LOG
  echo "Timestamp: $(date)" >> $LOG
  echo "Otwarte porty:" >> $LOG
  ss -tuln >> $LOG
  echo "----------" >> $LOG
  sleep $PERIOD
done

