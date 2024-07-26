# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
import math

def testfunc(n):
    if n % 4 == 0:
        proAngleVar = math.pi * (180.0 / n) / 180
    else:
        proAngleVar = math.pi * (180.0 / (2 * n)) / 180

    negX = 1.0e+99
    posX = -1.0e+99
    negY = 1.0e+99
    posY = -1.0e+99

    for j in range(n):
        px = math.cos(2 * math.pi * j / n + proAngleVar)
        py = math.sin(2 * math.pi * j / n + proAngleVar)
        negX = min(negX, px)
        posX = max(posX, px)
        negY = min(negY, py)
        posY = max(posY, py)

    opt2 = max(posX - negX, posY - negY)
    return opt2 / math.sin(math.pi / n) / 2

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
    ret = are_equivalent(testfunc(5),1.618034)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(6),1.931852)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(3),1.0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(7),2.24698)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(4),1.0)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
