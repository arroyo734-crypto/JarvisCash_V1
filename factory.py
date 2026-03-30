import requests
import json
def generate(niche):
    print(f'?? Brainstorming: {niche}...')
    data = {'model': 'deepseek-r1:8b', 'prompt': f'Output ONLY raw SwiftUI for a {niche} widget.', 'stream': False}
    resp = requests.post('http://localhost:11434/api/generate', json=data).json()
    full = resp['response']
    if '</think>' in full: full = full.split('</think>')[-1]
    with open(f'{niche}.swift', 'w', encoding='utf-8') as f: f.write(full.strip())
    print(f'? {niche} Done!')

apps = ['Todo_Widget', 'Step_Counter', 'Gratitude_Log', 'Pomodoro_Timer']
for a in apps: generate(a)
