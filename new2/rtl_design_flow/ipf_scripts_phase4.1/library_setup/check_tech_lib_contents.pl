#!/usr/bin/perl -w

$fail_flag = 0;
$found_lib_definition = 0;
$variable_definition_started = 0;
$var_name = "";
$var_value = "";
$kitslib = "";
$file = "";

@technologies = qw(TSMC90G TSMC55LP TSMC40LP TSMC28HPM_9T TSMC28HPM_12T_8LM);
@filetypes = qw(VFILE ATPGLIB LIBLEF EDI_SLOWLIB EDI_FASTLIB WC_DB BC_DB WC_CAP_TABLE BC_CAP_TABLE);

open (TECHLIBSETUP, "./tech_lib_setup.tcl");

while ($line = <TECHLIBSETUP>) {


   if ($line =~ /\$env\(TECHNOLOGY\)\s+==/) {
      $found_lib_definition = 0;
   }

   if ($line =~ /\$env\(TECHNOLOGY\)\s+==\s+"(\w+)"/) {
      $technology = $1;
      $found_lib_definition = 1;
   }

   if ($found_lib_definition == 1) {

      if ($line =~ /^\s*set\s+(\w+)\s+"?(\S+)/) {
	 $var_name  = $1;
	 $var_value = $2;
	 $var_value =~ s/\$KITSLIB/$kitslib/g;
	 @temp_store = ($var_value);
         $variable_definition_started = 1;
      } elsif (($variable_definition_started) && ($line =~ /^\s*([^\s"]+)/)) {
	$var_value = $1;
	$var_value =~ s/\$KITSLIB/$kitslib/g;
	push @temp_store, $var_value;	
        }
	
      if ($variable_definition_started && (($line !~ /\\$/) || ($line =~ /^\s*"\s*$/))) {
	 $variable_definition_started = 0;

	 if ($var_name eq (("SLOWLIB") || ("FASTLIB"))) {
	   push @{$libs{$technology}}, @temp_store;
	 }

         if ($var_name eq "KITSLIB") {
	   $kitslib = $temp_store[0];
         }

	 if ($var_name eq "LIBLIB") {
	   push @{$dirs{$technology}}, @temp_store;
	 }
	
	foreach $filetype (@filetypes) {
	   if ($var_name eq $filetype) {
             push @{$files{$technology}}, @temp_store;
           }
        }
      }
   }
}


foreach $technology (keys %files) {

print "Technology is $technology\n";

foreach $dirname (@{$dirs{$technology}}) {
   foreach $libname (@{$libs{$technology}}) {
      if (-e "$dirname/$libname") {
      print "finding library paths\n";
      use File::Find;
	 find sub { print "library path $dirname/$libname\n"}, $dirname;
	$lib_path = "$dirname/$libname";
	 }
      }
      push(@libraries, $lib_path) unless grep{$_ eq $lib_path} @libraries;


push (@libraries, @{$files{$technology}});

#make the items in the array unique, i.e strip out duplicates and check valid paths
foreach $filename (@{$files{$technology}}) {
   if (exists $entry_exists{$filename}) {
      next;
   } else {
     $entry_exists{$filename} = 1;
   }
   if (-e "$filename") {
     print "Found $filename\n";
   } else {
     $fail_flag = 1;
     print "ERROR invalid path, please check $filename in $technology before releasing\n";
   }
}
}
}

if ($fail_flag ==1) {
   print "FILE incomplete DO NOT RELEASE\n";
   } else {
   print "FILE ok Ready for RELEASE\n";
}
