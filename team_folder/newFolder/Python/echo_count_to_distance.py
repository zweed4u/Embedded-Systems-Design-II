#/usr/bin/python

class EchoCalc:
    def __init__(self):
        self.SYS_CLK = 100000000  # 100 MHZ
        self.SOUND_CM_S = 34300  # cm/s

    def time_high(self, high_pulse_count):
        """
        Convert count of high sensor pulse to a time in seconds given system clock
        :param high_pulse_count: int
        return: int
        """
        return high_pulse_count / float(self.SYS_CLK)

    def get_distance_cm(self, high_pulse_count):
        """
        Convert high pulse count to distance in cm
        :param high_pulse_count: int
        return: int
        """
        return self.time_high(high_pulse_count) * (self.SOUND_CM_S / 2)
