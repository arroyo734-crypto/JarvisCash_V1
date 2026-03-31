import os, time, subprocess
print('🛰️ 17 PRO MAINFRAME OPERATOR: ONLINE...')
def fling():
    print('🚀 ALPHA DETECTED. FLINGING CODE...')
    subprocess.run(['git', 'add', '.'])
    subprocess.run(['git', 'commit', '-m', 'Jarvis 2.0: Autonomous Update'])
    subprocess.run(['git', 'push', 'origin', 'main'])
    print('✅ CODE FLUNG.')
while True:
    if os.path.exists('trigger_signal.txt'):
        fling()
        os.remove('trigger_signal.txt')
    time.sleep(5)
