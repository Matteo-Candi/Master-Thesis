# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(fileName):
    digitNum = 0
    dotNum = 0
    if len(fileName) < 5 or not fileName[0].isalpha():
        return "No"
    suffix = fileName[-4:]
    if not suffix == ".txt" and not suffix == ".exe" and not suffix == ".dll":
        return "No"
    for c in fileName:
        if c.isdigit():
            digitNum += 1
        if c == '.':
            dotNum += 1
    if digitNum > 3 or dotNum != 1:
        return "No"
    return "Yes"
# End here


def serialize_list(obj) -> str:
    list_str = ["["]
    for item in obj:
        list_str.append(serialize_obj(item))
        list_str.append(",")
    list_str[-1] = "]"
    return "".join(list_str)


def serialize_dict(obj) -> str:
    m = OrderedDict(sorted(obj.items()))
    dict_str = ["{"]
    for key, value in m.items():
        dict_str.append(serialize_obj(key))
        dict_str.append(":")
        dict_str.append(serialize_obj(value))
        dict_str.append(",")
    dict_str[-1] = "}"
    return "".join(dict_str)


def serialize_obj(obj) -> str:
    if obj is None:
        return "null"
    if isinstance(obj, int) or isinstance(obj, float):
        return "{0:.6f}".format(obj)
    if isinstance(obj, str):
        return '"' + obj + '"'
    if isinstance(obj, bool):
        return str(obj)
    if isinstance(obj, list):
        return serialize_list(obj)
    if isinstance(obj, dict):
        return serialize_dict(obj)
    raise Exception("Unrecognized Type!")


def are_equivalent(o1, o2) -> bool:
    print(serialize_obj(o1)+" "+serialize_obj(o2))
    return serialize_obj(o1) == serialize_obj(o2)


def start():
    ret = False
    count = 0
    total = 0
    # Write the unit tests here
    total += 1
    ret = are_equivalent(testfunc("example.txt"),"Yes")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("1example.dll"),"No")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("s1sdf3.asd"),"No")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("K.dll"),"Yes")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("MY16FILE3.exe"),"Yes")
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
