# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(mat, s):
    n = len(mat)
    m = len(mat[0])
    count = 0
    for i in range(n):
        for j in range(m):
            if mat[i][j] != int(s[i + j]):
                count += 1
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
    ret = are_equivalent(testfunc([[1,2],[3,4],[5,6]],"123456"),4)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([[1,2,3],[3,4,5],[5,6,6]],"1233455"),6)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([[1,2,5],[2,3,3]],"012345"),5)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([[1,2],[1,2]],"02222"),2)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([[1,2,5],[2,3,3]],"0122333"),6)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
