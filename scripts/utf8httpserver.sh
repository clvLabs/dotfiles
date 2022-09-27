#!/bin/bash
echo "-"
echo "- Starting UTF-8 Python http.server"
echo "-"
python3 -c "from http.server import test, SimpleHTTPRequestHandler as RH; RH.extensions_map={k:v+';charset=UTF-8' for k,v in RH.extensions_map.items()}; test(RH)"
