# Set default engine to XeLaTeX (pdf_mode = 5)
$pdf_mode = 5;
$dvi_mode = 0;
$postscript_mode = 0;

# Define xelatex command with necessary flags
# -synctex=1: Enable forward/reverse search in PDF viewers
# --shell-escape: Allow execution of external programs (required by minted, etc.)
# -interaction=nonstopmode: Don't pause on errors
$xelatex = 'xelatex %O -synctex=1 --shell-escape -interaction=nonstopmode %S';

# --- Custom Dependency for Sub-files ---

# Tell latexmk: if 'figures/A.pdf' is missing or outdated but 'figures/A.tex' exists,
# use the 'make_external_pdf' subroutine to generate it.
add_cus_dep('tex', 'pdf', 0, 'make_external_pdf');

sub make_external_pdf {
    my ($base) = $_[0];
    
    # Execute a nested latexmk process for the sub-file.
    # -pdf: Generate PDF output
    # -cd: Change to the directory of the source file before processing. 
    # This ensures that relative paths inside the sub-file (like data files) work correctly.
    return system("latexmk -xelatex -cd \"$base.tex\"");
}
