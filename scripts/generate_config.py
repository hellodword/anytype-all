# /// script
# requires-python = ">=3.10"
# dependencies = [
#     "python-dotenv",
# ]
# ///
import os
import re
from pathlib import Path
from dotenv import load_dotenv

load_dotenv()

configs_dir = Path("configs")
template_suffix = ".yml.template"
output_suffix = ""

env_var_pattern = re.compile(r"\$(\w+)")

def replace_env_variables(template_content):
    def replacer(match):
        env_var = match.group(1)
        return os.getenv(env_var, f"${env_var}")

    return env_var_pattern.sub(replacer, template_content)

for template_file in configs_dir.glob(f"*{template_suffix}"):

    with open(template_file, "r", encoding="utf-8") as f:
        template_content = f.read()

    replaced_content = replace_env_variables(template_content)

    output_file = template_file.with_suffix(output_suffix)
    with open(output_file, "w", encoding="utf-8") as f:
        f.write(replaced_content)
    
    print(f"Processed: {template_file} -> {output_file}")
