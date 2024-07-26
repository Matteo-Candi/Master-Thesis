# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(s, n):
    count = 0
    i = 0
    while i < n - 2:
        if s[i] == '0' and s[i+1] == '1' and s[i+2] == '0':
            count += 1
            i += 3
        elif s[i] == '1' and s[i+1] == '0' and s[i+2] == '1':
            count += 1
            i += 3
        else:
            i += 1
    return count
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
    ret = are_equivalent(testfunc("101001100",9),1)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("1010010",7),2)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("10100100101000",14),3)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("010101010101",12),4)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("11110000",8),0)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
