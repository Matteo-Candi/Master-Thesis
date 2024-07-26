# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(p, q, k, n):
    ss = set()
    for i in range(n):
        sum = 0
        s = ""
        for j in range(i, n):
            pos = ord(p[j]) - ord('a')
            sum += int(q[pos])
            s += p[j]
            if sum <= k:
                ss.add(s)
            else:
                break
    return len(ss)

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
    ret = are_equivalent(testfunc("abcde","11111",3,5),12)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("abcde","11111",1,5),5)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("aaa","123",1,3),1)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("aabbaa","123456",2,6),3)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("ccb","101",3,3),5)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
