import xml.etree.ElementTree as ElementTree

ifile = open('pma_cdb.xml', 'r')

tree = ElementTree.parse(ifile)

ifile.close

root = tree.getroot()

