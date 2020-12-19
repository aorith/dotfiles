from kittens.tui.handler import result_handler


def main(args):
    pass


@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    tab = boss.active_tab
    boss.launch(
        "--allow-remote-control",
        "--type=os-window",
        "--title=Broadcast",
        "/bin/bash",
        "-lc",
        f"kitty +kitten broadcast --match-tab=id:{tab.id}",
    )
