#!/usr/bin/env python
import os
import subprocess
import sys
import time

# Colors aur Styles
CYAN = "\033[36m"
WHITE = "\033[97m"
BOLD = "\033[1m"
RESET = "\033[0m"
BLUE = "\033[34m"
GRAY = "\033[90m"

def clear_screen():
    os.system('clear')

def draw_header():
    clear_screen()
    print(f"{CYAN}╭───────────────────────────────────────────────────╮{RESET}")
    print(f"{CYAN}│{RESET}  {BOLD}{WHITE} AmitCompressor VYO v1.0{RESET}               {CYAN}│{RESET}")
    print(f"{CYAN}╰───────────────────────────────────────────────────╯{RESET}")

def get_duration(path):
    cmd = ['ffprobe', '-v', 'error', '-show_entries', 'format=duration', '-of', 'default=noprint_wrappers=1:nokey=1', path]
    result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    try:
        return float(result.stdout.strip())
    except:
        return 1

def compress():
    draw_header()
    
    print(f"\n {BLUE}{RESET} {BOLD}Enter Video Path:{RESET}")
    video_path = input(f" {GRAY}└─>{RESET} ").strip().replace("'", "").replace('"', "")
    
    if not os.path.exists(video_path):
        print(f"\n {CYAN}┌─ Error ───────────────────────────────┐{RESET}")
        print(f" {CYAN}│{RESET} [!] File Not Found!                  {CYAN}│{RESET}")
        print(f" {CYAN}╰───────────────────────────────────────╯{RESET}")
        return

    orig_size_mb = os.path.getsize(video_path) / (1024 * 1024)
    duration = get_duration(video_path)

    # Simple Options with Estimated Size
    targets = {
        '1': (orig_size_mb * 0.70, "Low", "28"),
        '2': (orig_size_mb * 0.45, "Medium", "32"),
        '3': (orig_size_mb * 0.20, "High", "38")
    }

    print(f"\n {BLUE}{RESET} {BOLD}Current Size: {orig_size_mb:.2f} MB{RESET}")
    print(f" {CYAN}╭───────────────────────────────────────────────────╮{RESET}")
    for k, v in targets.items():
        print(f" {CYAN}│{RESET} {k}. {WHITE}{v[1]} {GRAY}→ ~{v[0]:.1f} MB [Estimated]{RESET}         {CYAN}│{RESET}")
    print(f" {CYAN}╰───────────────────────────────────────────────────╯{RESET}")
    
    choice = input(f" {BLUE}{RESET} Choose Level (1-3): ")
    target_data = targets.get(choice, targets['2'])
    crf_val = target_data[2]
    
    # Bitrate Cap calculation to prevent size increase
    # Hum ek ceiling (chhat) laga rahe hain taaki size limit mein rahe
    max_bitrate = int((target_data[0] * 8192) / duration)

    output_path = video_path.rsplit('.', 1)[0] + "_comp.mp4"

    # DIRECT COMPRESSION (Single Pass)
    # -crf quality control karega aur -maxrate size ko control karega
    cmd = [
        'ffmpeg', '-i', video_path,
        '-vcodec', 'libx264', '-crf', crf_val, 
        '-maxrate', f'{max_bitrate}k', '-bufsize', f'{max_bitrate*2}k',
        '-preset', 'veryfast', '-progress', 'pipe:1', '-nostats', '-y', output_path
    ]

    print(f"\n {BOLD}➤ Compressing...{RESET}")
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True)
    
    try:
        for line in process.stdout:
            if "out_time_ms=" in line:
                val = line.split('=')[1].strip()
                if val.isdigit():
                    percent = (int(val) / 1000000) / duration * 100
                    percent = min(percent, 100)
                    filled = int(percent / 5)
                    bar = f"{BLUE}█{RESET}" * filled + f"{GRAY}▒{RESET}" * (20 - filled)
                    sys.stdout.write(f"\r {CYAN}│{RESET} {bar} {percent:.1f}% ")
                    sys.stdout.flush()

        process.wait()

        new_size_mb = os.path.getsize(output_path) / (1024 * 1024)
        draw_header()
        print(f"\n {BOLD}{WHITE}✓ COMPLETED SUCCESSFULLY{RESET}")
        print(f" {CYAN}┌───────────────────────────────────────────────────┐{RESET}")
        print(f" {CYAN}│{RESET} {BOLD}Original:{RESET} {orig_size_mb:.2f} MB                        {CYAN}│{RESET}")
        print(f" {CYAN}│{RESET} {BOLD}New Size:{RESET} {new_size_mb:.2f} MB                        {CYAN}│{RESET}")
        print(f" {CYAN}│{RESET} {BOLD}Saved:   {RESET} {orig_size_mb - new_size_mb:.2f} MB                       {CYAN}│{RESET}")
        print(f" {CYAN}└───────────────────────────────────────────────────┘{RESET}")
        print(f" {GRAY}Path: {os.path.basename(output_path)}{RESET}\n")

    except KeyboardInterrupt:
        process.kill()
        print(f"\n\n {BOLD}✖ Cancelled.{RESET}")

if __name__ == "__main__":
    compress()
