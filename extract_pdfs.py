#!/usr/bin/env python3
import sys
import os

# Try pypdf first, fallback to other methods
try:
    from pypdf import PdfReader
    print("✓ pypdf available")
except ImportError:
    print("✗ pypdf not available, attempting install...")
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "pypdf"])
    from pypdf import PdfReader
    print("✓ pypdf installed")

pdf_files = [
    r"C:\Users\karlc\Downloads\HYBRID_MOBILE_TERM_END.pdf",
    r"C:\Users\karlc\Downloads\Story Game.pdf"
]

for pdf_path in pdf_files:
    filename = os.path.basename(pdf_path)
    
    print("\n" + "="*80)
    print(f"FILE: {filename}")
    print(f"PATH: {pdf_path}")
    print("="*80)
    
    if not os.path.exists(pdf_path):
        print(f"ERROR: File not found!")
        continue
    
    try:
        reader = PdfReader(pdf_path)
        total_pages = len(reader.pages)
        print(f"Total pages: {total_pages}\n")
        
        for page_num, page in enumerate(reader.pages, 1):
            print(f"\n{'-'*80}")
            print(f"PAGE: {page_num}/{total_pages}")
            print(f"{'-'*80}\n")
            
            try:
                text = page.extract_text()
                if text and text.strip():
                    print(text)
                else:
                    print("[*** NO EXTRACTABLE TEXT ON THIS PAGE ***]")
            except Exception as e:
                print(f"[*** ERROR EXTRACTING TEXT: {e} ***]")
            
            print()
    
    except Exception as e:
        print(f"Error reading PDF: {e}")

print("\n" + "="*80)
print("EXTRACTION COMPLETE")
print("="*80)
