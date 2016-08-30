#!/bin/bash

top $(ps ax |grep phantom | grep -v $0 | grep -v php | grep -v grep | awk '{print "-p " $1}')

