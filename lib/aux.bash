#!/usr/bin/env /bin/bash
###
#  @file   aux.bash
#  @brief  Auxilirary Functions
#  @author KrizTioaN (christiaanboersma@hotmail.com)
#  @date   2021-07-24
#  @note   BSD-3 licensed
#
###############################################

function message {
    /usr/local/bin/unbuffer echo "$(date "+%m-%d-%Y %H:%M:%S: $1")"
}
