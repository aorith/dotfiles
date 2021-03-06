#!/usr/bin/env python3

import sys
import subprocess
from i3ipc import Connection, Event

TDIR = {"left": "left", "right": "right", "up": "top", "down": "bottom"}
TSEL = {"left": "L", "right": "R", "up": "U", "down": "D"}


i3 = Connection()
tree = i3.get_tree()
f = tree.find_focused()
w = f.workspace()
p = f.parent


def get_container_idx_at(cid: int, pos: int, l: list) -> int:
    """to focus next or prev container:
    prev container; pos = -1
    next container; pos =  1"""
    for idx, i in enumerate(l):
        if i.id == cid:
            break

    if idx is None:
        return -1
    else:
        return l[(idx + pos) % len(l)].id


def focus_tab(pos):
    if p.layout == "tabbed":
        i3.command(
            "[con_id={}] focus".format(get_container_idx_at(f.id, pos, p.descendants()))
        )


def focus(direction):
    if (
        "tmux" in f.window_instance
        and subprocess.run(
            [
                "tmux",
                "display-message",
                "-p",
                "#{pane_at_" + "{}".format(TDIR[direction]) + "}",
            ],
            capture_output=True,
        )
        .stdout.decode("utf-8")
        .strip()
        == "0"
    ):
        subprocess.run(["tmux", "select-pane", "-{}".format(TSEL[direction])])
    elif (
        p.layout == "tabbed"
        and direction in ["left", "right"]
        and len(w.leaves()) != len(p.leaves())
    ):
        i3.command("focus parent; focus {}".format(direction))
    else:
        i3.command("focus {}".format(direction))


if sys.argv[1] == "tab":
    if sys.argv[2] == "next":
        focus_tab(1)
    else:
        focus_tab(-1)
elif sys.argv[1] == "focus":
    try:
        focus(sys.argv[2])
    except Exception as err:
        print("i3-focus.py: " + str(err))
        i3.command("focus {}".format(sys.argv[2]))
