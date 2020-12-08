from sys import exit

def main(args):
    # this is the main entry point of the kitten, it will be executed in
    # the overlay window when the kitten is launched
    print("Send to all windows in this Tab.\n")
    try:
        answer = input("> ")
    except KeyboardInterrupt:
        print("Cancelled.")
        exit(0)
    # whatever this function returns will be available in the
    # handle_result() function
    return answer


def handle_result(args, answer, target_window_id, boss):
    tab = boss.active_tab
    windows_dict = tab.list_windows(target_window_id)
    for w_dict in windows_dict:
        w = boss.window_id_map.get(w_dict.get("id"))
        if w is not None:
            #w.paste_bytes(answer + "\x0d")
            w.paste(answer + "\r")

