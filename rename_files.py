import os

def sanitize(filename):
    # Reemplazar caracteres especiales
    translations = str.maketrans({
        "á": "a", "é": "e", "í": "i", "ó": "o", "ú": "u",
        "Á": "A", "É": "E", "Í": "I", "Ó": "O", "Ú": "U",
        "ñ": "n", "Ñ": "N"
    })
    return filename.translate(translations)

for dirpath, dirnames, filenames in os.walk("."):
    for filename in filenames + dirnames:
        sanitized_name = sanitize(filename)
        if sanitized_name != filename:
            src = os.path.join(dirpath, filename)
            dest = os.path.join(dirpath, sanitized_name)
            os.rename(src, dest)
            print(f"Renamed {src} to {dest}")
