def main(args):
    pass


def handle_result(args, answer, target_window_id, boss):
    zoom_txt = "\x1b[38:2:252:252:2m[F]"
    tab = boss.active_tab
    if tab is not None:
        title = tab.title
        if tab.current_layout.name == "stack":
            tab.last_used_layout()
            tab.set_title(title.replace(zoom_txt, ""))
        else:
            tab.goto_layout("stack")
            tab.set_title(zoom_txt + title)


handle_result.no_ui = True
