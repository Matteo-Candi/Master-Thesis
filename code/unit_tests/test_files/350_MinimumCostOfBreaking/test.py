# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(x, y, m, n):
    res = 0
    x.sort(reverse=True)
    y.sort(reverse=True)
    hzntl = 1
    vert = 1
    i = 0
    j = 0
    while i < m and j < n:
        if x[i] > y[j]:
            res += x[i] * vert
            hzntl += 1
            i += 1
        else:
            res += y[j] * hzntl
            vert += 1
            j += 1
    total = 0
    while i < m:
        total += x[i]
        i += 1
    res += total * vert
    total = 0
    while j < n:
        total += y[j]
        j += 1
    res += total * hzntl
    return res

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
    ret = are_equivalent(testfunc([3,1,2],[2,1],3,2),17)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([5,2],[6,4,1],2,3),33)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([10,5,12],[6,3],3,2),62)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,2,3],[4,5],3,2),27)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([4,5],[1,2,3],2,3),27)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
