#!/usr/bin/env python3
#
# Copy this file as notify.py and adjust paths below.
# It should be called as `python notify.py <account>` where <account> is the
# name of the maildir directory.

import hashlib
import json
import logging
import os
import subprocess
import sys

from pathlib import Path

logging.basicConfig(level=logging.INFO)

ALLOWED = (
    "<account>",
)

account = "<default>"
if len(sys.argv) > 1:
    account = sys.argv[1]

if account not in ALLOWED:
    exit(0)

MAILDIR = Path(f"/data/mail/{account}")
MAILSUMS_PATH = MAILDIR / Path('.mailsums.json')
# Subdirectories to send notifications for.
DIRS = (
    MAILDIR / Path("INBOX"),
    MAILDIR / Path("INBOX/<subdir1>"),
    # ...
)
NEW_MAILS = []
MAILSUMS = []
MESSAGES = []

if MAILSUMS_PATH.exists():
    with open(MAILSUMS_PATH, 'r') as f:
        MAILSUMS = json.load(f)["sums"]

for d in DIRS:
    number_of_mails = 0
    logging.info(f"Analyzing {d}...")
    for mail in d.glob('new/*'):
        sum = hashlib.md5(str(mail).encode("utf-8")).hexdigest()
        if sum not in MAILSUMS:
            logging.info(f"Will send notification for {mail.name}")
            MAILSUMS += [sum]
            number_of_mails += 1
    if number_of_mails > 0:
        MESSAGES += [f"{number_of_mails} in {d.name}"]

if MESSAGES:
    with open(MAILSUMS_PATH, 'w') as f:
        json.dump({"sums": MAILSUMS}, f)
    subprocess.run(
        ["/usr/bin/notify-send",
         "--icon", "/usr/share/icons/Papirus/16x16/actions/mail-unread-new.svg",
         "-a", "mail", "new mail", "\n".join(MESSAGES)])
