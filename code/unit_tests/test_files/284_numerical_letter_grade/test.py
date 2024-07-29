# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(grades):
    letterGrade = []
    for gpa in grades:
        if gpa == 4.0:
            letterGrade.append("A+")
        elif gpa > 3.7:
            letterGrade.append("A")
        elif gpa > 3.3:
            letterGrade.append("A-")
        elif gpa > 3.0:
            letterGrade.append("B+")
        elif gpa > 2.7:
            letterGrade.append("B")
        elif gpa > 2.3:
            letterGrade.append("B-")
        elif gpa > 2.0:
            letterGrade.append("C+")
        elif gpa > 1.7:
            letterGrade.append("C")
        elif gpa > 1.3:
            letterGrade.append("C-")
        elif gpa > 1.0:
            letterGrade.append("D+")
        elif gpa > 0.7:
            letterGrade.append("D")
        elif gpa > 0.0:
            letterGrade.append("D-")
        else:
            letterGrade.append("E")
    return letterGrade

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
    ret = are_equivalent(testfunc([4.0,3.0,1.7,2.0,3.5]),["A+","B","C-","C","A-"])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1.2]),["D+"])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([0.5]),["D-"])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([0.0]),["E"])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1.0,0.3,1.5,2.8,3.3]),["D","D-","C-","B","B+"])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
