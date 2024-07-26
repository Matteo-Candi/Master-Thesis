# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(file_name):
    digit_num = 0
    dot_num = 0
    if len(file_name) < 5 or not file_name[0].isalpha():
        return "No"
    suffix = file_name[-4:]
    if suffix != ".txt" and suffix != ".exe" and suffix != ".dll":
        return "No"
    for c in file_name:
        if c.isdigit():
            digit_num += 1
        if c == '.':
            dot_num += 1
    if digit_num > 3 or dot_num != 1:
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
