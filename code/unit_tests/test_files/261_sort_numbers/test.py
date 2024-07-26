# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(numbers):
    toNum = {"zero": 0, "one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9}
    fromNum = {0: "zero", 1: "one", 2: "two", 3: "three", 4: "four", 5: "five", 6: "six", 7: "seven", 8: "eight", 9: "nine"}
    ints = []
    current = ""
    for i in range(len(numbers) + 1):
        if i == len(numbers) or numbers[i] == ' ':
            if current in toNum:
                ints.append(toNum[current])
                current = ""
        else:
            current += numbers[i]
    ints.sort()
    result = ""
    for i in range(len(ints)):
        result += fromNum[ints[i]]
        if i != len(ints) - 1:
            result += " "
    return result
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
    ret = are_equivalent(testfunc(""),"")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("three"),"three")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("three five nine"),"three five nine")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("five zero four seven nine eight"),"zero four five seven eight nine")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("six five four three two one zero"),"zero one two three four five six")
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
