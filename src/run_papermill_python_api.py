import datetime
import logging
import papermill as pm

logger = logging.getLogger()
logger.setLevel(logging.INFO)

class RunPaperMillPipeline():

    def __init__(self):
        self.run_date = datetime.datetime.today().strftime('%Y-%m-%d')
        self.image_path = ''
        self.pipeline_list = ['test_coral']

    def execute_notebook(self, name):
        """

        """
        pm.execute_notebook(
            './{}.ipynb'.format(name),
            './output/{}_output.ipynb'.format(name),
            parameters=dict(dt=self.run_date, types=self.pipeline_list)
        )
    def run(self):
        print(self.pipeline_list)
        for name in self.pipeline_list:
            self.execute_notebook(name)

pipeline = RunPaperMillPipeline()
logging.info("START pipeline")
pipeline.run()
