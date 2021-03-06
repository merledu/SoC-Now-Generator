from cmath import nan
import subprocess,os,json
from unittest import TestCase

# class SoC_Tester(TestCase):

#     def test_soc_combination(self):
#         # assert True
#         # os.chdir("../../")
#         print(f"CURRENT DIR = {os.system('pwd')}")
#         defaults = {"i": 1, "gpio": 1}
#         extensions = {"m": 1, "f": 0, "c": 0}
#         devices = {"spi": 0, "uart": 0, "timer": 0, "spi_flash": 1, "i2c": 0}
#         bus = {"wb": 0, "tl": 0}
#         total_combinations = 2**len(extensions.keys()) * 2**len(devices.keys()) * len(bus.keys())
#         print(f"\n Total Combinations: {total_combinations}\n")
#         comb_count = 0
#         import itertools
#         from typing import final
#         device_combs = list(itertools.product([0, 1], repeat=len(devices.keys())))
#         extension_combs = list(itertools.product([0, 1], repeat=len(extensions.keys())))
#         bus_combs = [ [0]*len(bus.keys())  for i,v in enumerate(bus.keys())]
#         for i,v in enumerate(bus_combs):
#             v[i] = 1

#         for i,v in enumerate(bus_combs):
#             # current bus comb
#             final_dict = dict(zip(bus.keys(), v))

#             for j,w in enumerate(extension_combs):
#                 # current ext comb
#                 final_dict |= dict(zip(extensions.keys(), w))

#                 for k,x in enumerate(device_combs):
#                     # current dev comb
#                     final_dict |= dict(zip(devices.keys(), x))

#                     final_dict |= defaults
#                     # attach code here
#                     comb_count+=1
#                     print(f"\nCurrent Combination #{comb_count} : {final_dict}\n")
#                     file = open("src/main/scala/config.json","w")
#                     json.dump(final_dict, file)
#                     file.close()

#                     yield True

                    # process = subprocess.Popen(["sbt","test"], stdout=subprocess.PIPE)
                    # while True:
                    #     output = process.stdout.readline()
                    #     if output == '' and process.poll() is not None:
                    #         break
                    #     if output:
                    #         # print(str(output))
                    #         if "[info] All tests passed." in str(output):
                    #             print("TEST PASSED :)")
                    #             self.assertTrue(True)
                    #             break
                    #         if "TEST FAILED" in str(output):
                    #             print("TEST FAILES :(")
                    #             self.assertTrue(False)
                    #             break
            #         break
            #     break
            # break


def nana():
    file = open("combinations.json","w")
    json.dump({},file)
    file.close()
    print(f"CURRENT DIR = {os.system('pwd')}")
    defaults = {"i": 1, "gpio": 1}
    extensions = {"m": 1, "f": 0, "c": 0}
    devices = {"spi": 0, "uart": 0, "timer": 0, "spi_flash": 1, "i2c": 0}
    bus = {"wb": 0, "tl": 0}
    total_combinations = 2**len(extensions.keys()) * 2**len(devices.keys()) * len(bus.keys())
    print(f"\n Total Combinations: {total_combinations}\n")
    comb_count = 0
    import itertools
    from typing import final
    device_combs = list(itertools.product([0, 1], repeat=len(devices.keys())))
    extension_combs = list(itertools.product([0, 1], repeat=len(extensions.keys())))
    bus_combs = [ [0]*len(bus.keys())  for i,v in enumerate(bus.keys())]
    for i,v in enumerate(bus_combs):
        v[i] = 1

    for i,v in enumerate(bus_combs):
        # current bus comb
        final_dict = dict(zip(bus.keys(), v))

        for j,w in enumerate(extension_combs):
            # current ext comb
            final_dict |= dict(zip(extensions.keys(), w))

            for k,x in enumerate(device_combs):
                # current dev comb
                final_dict |= dict(zip(devices.keys(), x))

                final_dict |= defaults
                # attach code here
               
                print(f"\nCurrent Combination #{comb_count} : {final_dict}\n")
                file = open("combinations.json")
                data = json.load(file)
                file.close()
                file = open("combinations.json","w")
                data[comb_count] = final_dict
                json.dump(data, file)
                file.close()
                comb_count+=1


import sys           
current_val = sys.argv[1]
if current_val == "all":
    nana()
else:
    file = open("combinations.json")
    data = json.load(file)
    file.close()
    file = open("src/main/scala/config.json", "w")
    json.dump(data[sys.argv[1]], file)
    file.close()
