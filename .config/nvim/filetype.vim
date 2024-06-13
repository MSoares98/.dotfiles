augroup filetypedetect
 au! BufRead,BufNewFile in.*           setfiletype lammps
 au! BufRead,BufNewFile *.lmp          setfiletype lammps
 au! BufRead,BufNewFile *.in           setfiletype lammps
 au! BufRead,BufNewFile *.inp          setfiletype cp2k
 au! BufRead,BufNewFile *.restart      setfiletype cp2k
augroup END
