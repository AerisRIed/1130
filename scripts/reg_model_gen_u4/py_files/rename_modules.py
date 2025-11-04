import subprocess
import os
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-f', action = 'store', type=str, default="xtensa.f", help="DOT F of the design to be renamed")
parser.add_argument('-o', action = 'store', type=str, default="workdir", help="Directory renamed code will be put into (if exists - script will exit)")
parser.add_argument('-s', action = 'store', type=str, default="cdn_22", help="Suffix to be added to module names")

args    = parser.parse_args()
dot_f   = args.f
workdir = args.o
suffix  = args.s

#Get modules from VHIER Program
comp_proc = subprocess.run(["vhier", "--modules", "-f", dot_f], capture_output=True)
modules   = str(comp_proc.stdout)
modules   = modules.split()
modules   = modules[1:]

#Get module-files from VHIER Program
comp_proc    = subprocess.run(["vhier", "--module-files", "-f", dot_f], capture_output=True)
module_files = str(comp_proc.stdout)
module_files = module_files.split()
module_files = module_files[1:]

try :
   os.mkdir(workdir)
except :
   import sys
   print("ERROR ::  Output Directory Exists")
   sys.exit(1)

#Copy used files into tmp work directory
for ff in module_files:
   cp_file   = ff.rstrip()
   cp_file   = cp_file.replace('\\n', '')
   cp_file   = cp_file.replace("'", '')
   comp_proc = subprocess.run(["cp", "-p", cp_file, workdir])

flist = os.listdir(workdir)

df  = open(workdir+'/IP.f', 'w')
dfr = open(workdir+'/IP_rel.F', 'w')
for ff in flist:
   ff1 = ff.replace('.', '_'+suffix+'.')
   df.write('<ABS_PATH>.'+ff1+'\n')
   dfr.write(ff1+'\n')
   os.rename(workdir+'/'+ff, workdir+'/'+ff1)
df.close()
dfr.close()

#Create signals.vrename file
with open('signals.vrename', 'w') as f :
   for md in modules:
      mod = md.rstrip()
      mod = mod.replace('\\n', '')
      mod = mod.replace("'", '')
      new_mod = mod+'_'+suffix
      f.write('sigren   "'+mod+'"        "'+new_mod+'"\n')

#Create the Signal List 
comp_proc = subprocess.run(["vrename", "--change", workdir])

os.remove('signals.vrename')
