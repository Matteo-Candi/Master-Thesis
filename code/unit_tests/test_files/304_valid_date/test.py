# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(date):
    if len(date) != 10:
        return False
    for i in range(10):
        if i == 2 or i == 5:
            if date[i] != '-':
                return False
        elif not date[i].isdigit():
            return False
    month = int(date[:2])
    day = int(date[3:5])
    year = int(date[6:10])
    if month < 1 or month > 12:
        return False
    if day < 1 or day > 31:
        return False
    if day == 31 and month in [4, 6, 9, 11, 2]:
        return False
    if day == 30 and month == 2:
        return False
    return True

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
    ret = are_equivalent(testfunc("03-11-2000"),True)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("15-01-2012"),False)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("04-0-2040"),False)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("04-12-2003"),True)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("21-31-2000"),False)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
