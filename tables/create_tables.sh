#!/usr/bin/env bash
HOSTNAME=$(hostname)
if [ "$HOSTNAME" == "ProBook" ]
then
    EXCEL2LATEX=/mnt/d/work/code/excel-to-latex/excel_to_latex/excel_to_latex.py
else
    EXCEL2LATEX=/u/vieting/Documents/text/excel-to-latex/excel_to_latex/excel_to_latex.py
fi

python ${EXCEL2LATEX} --file_in features.xlsx --all_lines --vertical_merge --sheet general --wer_cols E F G H
python ${EXCEL2LATEX} --file_in features.xlsx --all_lines --vertical_merge --sheet pretraining --wer_cols C D E F
python ${EXCEL2LATEX} --file_in features.xlsx --all_lines --vertical_merge --sheet window_size --wer_cols C D E F
python ${EXCEL2LATEX} --file_in features.xlsx --vertical_merge --sheet scf_size --wer_cols E F G H
python ${EXCEL2LATEX} --file_in features.xlsx --all_lines --vertical_merge --sheet w2v_size --wer_cols D E F G
python ${EXCEL2LATEX} --file_in features.xlsx --all_lines --vertical_merge --sheet w2v_proj --wer_cols C D E F

sed -i 's/\\end{tabular}/\\end{tabular}\n\\vspace{-0.05cm}/g' features_w2v_size.tex

