# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(s):
    n = len(s)
    firstIdx1 = -1
    lastIdx0 = -1
    for i in range(n):
        if s[i] == '1':
            firstIdx1 = i
            break
    for i in range(n-1, -1, -1):
        if s[i] == '0':
            lastIdx0 = i
            break
    if firstIdx1 == -1 or lastIdx0 == -1:
        return 0
    count1 = 0
    count0 = 0
    for i in range(lastIdx0):
        if s[i] == '1':
            count1 += 1
    for i in range(firstIdx1 + 1, n):
        if s[i] == '1':
            count0 += 1
    return min(count0, count1)
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
    ret = are_equivalent(testfunc("1010101010"),4)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("1111111111"),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("00001111"),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("0101000111"),2)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("0011111100"),5)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
