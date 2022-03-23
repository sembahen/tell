import os
import warnings

import joblib
import numpy as np
import pandas as pd
import sklearn
from sklearn.metrics import r2_score, mean_squared_error, mean_absolute_percentage_error


def scale_features(x_train: np.ndarray,
                   x_test: np.ndarray,
                   y_train: np.ndarray,
                   y_test: np.ndarray) -> dict:
    """Normalize the features and targets of the model.

    :param x_train:                         Training features
    :type x_train:                          np.ndarray

    :param x_test:                          Test features
    :type x_test:                           np.ndarray

    :param y_train:                         Training targets
    :type y_train:                          np.ndarray

    :param y_test:                          Training targets
    :type y_test:                           np.ndarray

    :return:                                Dictionary of scaled features

    """

    # get the mean and std of training set
    mu_x_train = np.mean(x_train)
    sigma_x_train = np.std(x_train)
    mu_y_train = np.mean(y_train)
    sigma_y_train = np.std(y_train)

    # normalize
    x_train_norm = np.divide((x_train - mu_x_train), sigma_x_train)
    x_test_norm = np.divide((x_test - mu_x_train), sigma_x_train)
    y_train_norm = np.divide((y_train - mu_y_train), sigma_y_train)

    if y_test is not None:
        y_test_norm = np.divide((y_test - mu_y_train), sigma_y_train)
    else:
        y_test_norm = None

    dict_out = {
        "mu_x_train": mu_x_train,
        "mu_y_train": mu_y_train,
        "sigma_x_train": sigma_x_train,
        "sigma_y_train": sigma_y_train,
        "x_train_norm": x_train_norm,
        "y_train_norm": y_train_norm,
        "x_test_norm": x_test_norm,
        "y_test_norm": y_test_norm,
    }

    return dict_out


def unscale_features(region: str,
                     normalized_dict: dict,
                     y_predicted_normalized: np.ndarray,
                     datetime_arr: np.ndarray) -> pd.DataFrame:
    """Function to denormlaize the predictions of the model.

    :param region:                              Indicating region / balancing authority we want to train and test on.
                                                Must match with string in CSV files.
    :type region:                               str

    :param normalized_dict:                     Dictionary output from normalization function.
    :type normalized_dict:                      dict

    :param y_predicted_normalized:              Normalized predictions over the test set.
    :type y_predicted_normalized:               np.ndarray

    :param datetime_arr:                        Array of datetimes corresponding to the predictions.
    :type datetime_arr:                         np.ndarray

    :return:                                    Denormalized predictions

    """

    # denormalize predicted Y
    y_p = y_predicted_normalized * normalized_dict["sigma_y_train"] + normalized_dict["mu_y_train"]

    # create data frame with datetime attached
    df = pd.DataFrame({"Datetime": datetime_arr, "Predictions": y_p})

    # add in region field
    df["region"] = region

    return df


def pickle_model(region: str,
                 model_object: object,
                 model_name: str,
                 output_directory: str):
    """Pickle model to file using joblib.  Version of scikit-learn is included in the file name as a compatible
    version is required to reload the data safely.

    :param region:                      Indicating region / balancing authority we want to train and test on.
                                        Must match with string in CSV files.
    :type region:                       str

    :param model_object:                    scikit-learn model object.
    :type model_object:                     object

    :param model_name:                      Name of sklearn model.
    :type model_name:                       str

    :param output_directory:                Full path to output directory where model file will be written.
    :type output_directory:                 str

    """

    # build output file name
    basename = f"{region}_{model_name}_scikit-learn-version-{sklearn.__version__}.joblib"
    output_file = os.path.join(output_directory, basename)

    # dump model to file
    joblib.dump(model_object, output_file)


def load_model(model_file: str) -> object:
    """Pickle model to file using joblib.  Version of scikit-learn is included in the file name as a compatible
    version is required to reload the data safely.

    :param model_file:                  Full path with filename an extension to the joblib pickled model file.
    :type model_file:                   str

    :return:                            Model as an object.

    """

    # get version of scikit-learn and compare with the model from file to ensure compatibility
    sk_model_version = os.path.splitext(model_file)[0].split('-')[-1]

    # get version of scikit-learn being used during runtime
    sk_run_version = sklearn.__version__

    if sk_model_version != sk_run_version:
        msg = f"WARNING: Incompatible scikit-learn version for saved model ({sk_model_version}) and current version ({sk_run_version})."
        warnings.warn(msg)

    # load model from
    return joblib.load(model_file)


def validate(region: str,
             y_predicted: np.ndarray,
             y_comparison: np.ndarray,
             nodata_value: int) -> pd.DataFrame:
    """Validation of model performance using the predicted compared to the test data.

    :param region:                      Indicating region / balancing authority we want to train and test on.
                                        Must match with string in CSV files.
    :type region:                       str

    :param y_predicted:                 Predicted Y result array.
    :type y_predicted:                  np.ndarray

    :param y_comparison:                Comparison test data for Y array.
    :type y_comparison:                 np.ndarray

    :param nodata_value:                No data value in the input CSV file.
    :type nodata_value:                 int

    :return:                            Data frame of stats.

    """

    # remove all the no data values in the comparison test data
    y_comp_clean_idx = np.where(y_comparison != nodata_value)
    y_comp = y_comparison[y_comp_clean_idx[0]].squeeze()

    # get matching predicted data
    y_pred = y_predicted[y_comp_clean_idx[0]]

    # first the absolute root-mean-squared error
    rms_abs = np.sqrt(mean_squared_error(y_pred, y_comp))

    # RMSE normalized
    rms_norm = rms_abs / np.mean(y_comp)

    # mean absolute percentage error
    mape = mean_absolute_percentage_error(y_pred, y_comp)

    # R2
    r2_val = r2_score(y_pred, y_comp)

    stats_dict = {"region": [region],
                  "RMS_ABS": [rms_abs],
                  "RMS_NORM": [rms_norm],
                  "MAPE": [mape],
                  "R2": [r2_val]}

    return pd.DataFrame(stats_dict)
